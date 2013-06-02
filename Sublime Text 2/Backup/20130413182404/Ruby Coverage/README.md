SublimeRubyCoverage
====================

A plugin for Sublime Text 2 that can highlight lines of Ruby lacking test coverage.

Installation
------------

You will need to setup [simplecov-sublime-ruby-coverage](http://github.com/integrum/simplecov-sublime-ruby-coverage) in your project.

Set up [Sublime Package Control](http://wbond.net/sublime_packages/package_control)
if you don't have it yet.

Go to Tools > Command Palette.
Type `Package Control: Install Package` and hit enter.
Type `Ruby Coverage` and hit enter.


Usage
-----

Ignoring Files
--------------

Add a .covignore file to your project root in order to add custom ignores.

Highlighting lines missing coverage
-----------------------------------

When you open a .rb file,
SublimeRubyCoverage tries to find coverage information
and highlight all uncovered lines with an outline.

It does this by looking in all parent directories
until it finds a `coverage/sublime-ruby-coverage` directory as produced by [simplecov-sublime-ruby-coverage](http://github.com/integrum/simplecov-sublime-ruby-coverage).
The coverage file is expected to have as many lines as the source file, with each line containing a 1 if the line is covered or a 0 if it is not.

You can force a reload of the coverage information
and redraw of the outlines
by running the `show_ruby_coverage` command,
bound to super+shift+c by default.
