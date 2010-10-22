Author: Norman Schleicher

This is the docbook version of SHR manual.
You can generate the following targets from this source:

  - HTML
  - PDF

The build system is checked in in compressed form(zip).
To install the build system go into the 'external' folder and
execute ant.

The build system runs only with jdk 1.6 (not 1.5 or 1.4 !).

Files Structure:

build.xml: master ant build file (add new projects here)

<src>:               worker buildfile, xsl/xml/png sources for documentation
<OUTPUT>:            location of the generated  documentaion (one subdirectory
                     per project)
<GENERATE/project>:  temoprary directory for generation process
<external>:          the docbook generation tools itself
<external/install>:  installation directotry of the unziped docbook tools
<configurations>:    directory which contains all configurations for different
                     types of manual.
                     
title page layout for print documentation:
The title page layout for print documentation is specified in the 
file src/titlepage.spec.shr-manual.xml. 
The Spec file is automatically converted to a xsl style sheet used during the 
creation process of the print doucmentation.  Once the layout is settled 
the phone specific content is driven by the file content of the bookinfo element
in SHR-Manual-.xml.
For further information on the customaization process of the title page see 
http://www.sagehill.net/docbookxsl/index.html.


Norman Schleicher

