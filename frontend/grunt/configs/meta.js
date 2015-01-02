/**
 * The banner is the comment that is placed at the top of our compiled
 * source files. It is first processed as a Grunt template, where the `<%=`
 * pairs are evaluated based on this very configuration object.
 */
module.exports =
{
  banner:
    '/**\n' +
    ' * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %>\n' +
    ' * <%= pkg.homepage %>\n' +
    ' *\n' +
    ' * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>\n' +
    ' <% if(pkg.licenses){ %>* Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>><% } %>\n' +
    ' */\n'
};
