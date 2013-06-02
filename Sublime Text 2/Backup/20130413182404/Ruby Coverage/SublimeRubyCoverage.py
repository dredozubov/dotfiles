import os
import sublime
import sublime_plugin
import re
PLUGIN_FILE = os.path.abspath(__file__)

def find_project_root(file_path):
    """Project Root is defined as the parent directory that contains a directory called 'coverage'"""
    if os.access(os.path.join(file_path, 'coverage'), os.R_OK):
        return file_path

    parent, current = os.path.split(file_path)
    if current:
        return find_project_root(parent)

def explode_path(path):
    first, second = os.path.split(path)
    if second:
        return explode_path(first) + [second]
    else:
        return [first]

class SublimeRubyCoverageListener(sublime_plugin.EventListener):
    """Event listener to highlight uncovered lines when a Ruby file is loaded."""

    def on_load(self, view):
        if 'source.ruby' not in view.scope_name(0):
            return

        view.run_command('show_ruby_coverage')

class ShowRubyCoverageCommand(sublime_plugin.TextCommand):
    """Highlight uncovered lines in the current file based on a previous coverage run."""

    def run(self, edit):
        view = self.view
        filename = view.file_name()
        if not filename:
            return

        if self.file_exempt(filename):
            return

        project_root = find_project_root(filename)
        if not project_root:
            print 'Could not find coverage directory.'
            return

        relative_file_path = os.path.relpath(filename, project_root)

        coverage_filename = '-'.join(explode_path(relative_file_path))[1:].replace(".rb", "_rb.csv")
        coverage_filepath = os.path.join(project_root, 'coverage', 'sublime-ruby-coverage', coverage_filename)

        # Clean up
        view.erase_status('SublimeRubyCoverage')
        view.erase_regions('SublimeRubyCoverage')
        
        outlines = []

        try:
            with open(coverage_filepath) as coverage_file:
                for current_line, line in enumerate(coverage_file):
                    if line.strip() != '1':
                        region = view.full_line(view.text_point(current_line, 0))
                        # join contiguous regions together
                        if len(outlines) > 0:
                            prev_region = outlines.pop()
                            if region.begin() == prev_region.end():
                                region = sublime.Region(prev_region.begin(), region.end())
                            else:
                                outlines.append(prev_region)

                        outlines.append(region)
        except IOError as e:
            # highlight the entire view
            outlines.append(sublime.Region(0,view.size()))
            view.set_status('SublimeRubyCoverage', 'UNCOVERED!')
            if view.window():
                sublime.error_message("Oh dear. We can't seem to find the coverage file. We tried looking here: " + coverage_filepath + ", but then we gave up.")

        # update highlighted regions
        if outlines:
            view.add_regions('SublimeRubyCoverage', outlines, 'comment',
                sublime.DRAW_EMPTY | sublime.DRAW_OUTLINED)

    def file_exempt(self, filename):
        normalized_filename = os.path.normpath(filename).replace('\\', '/')
        print normalized_filename

        exempt = [r'/test/', r'/spec/', r'/features/', r'Gemfile$', r'Rakefile$', r'\.rake$',
            r'\.gemspec']

        root = find_project_root(self.view.file_name())
        ignore = os.path.join(root, '.covignore')
        if os.path.isfile(ignore):
            for path in open(ignore).read().rstrip("\n").split("\n"):
                exempt.append(path)

        for pattern in exempt:
            print pattern
            if re.compile(pattern).search(normalized_filename) is not None:
                return True
        return False
