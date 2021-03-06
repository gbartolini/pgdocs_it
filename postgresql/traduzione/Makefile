#Ultima modifica
#   il	$Date$
#   di	$Author$
#   revisione	$Revision$

MAJORVER := $(shell grep major version.xml | sed -e 's/<!ENTITY majorversion "\(.*\)">/\1/' -e 's/\.//g')
VERSION := $(shell grep -v major version.xml | sed -e 's/<!ENTITY version "\(.*\)">/\1/')
VER := $(shell grep -v major version.xml | sed -e 's/<!ENTITY version "\(.*\)">/\1/' -e 's/\.//g')

$(shell test -z "$VERSION" && echo "Non riesco a determinare la versione di PostgreSQL dal file version.xml" && exit -1)

include ../Makefile.config

HTM_OUTPUT := pgsql-$(VER)-it
WEB_OUTPUT := web-$(VER)-it
WEBTEST_OUTPUT := web-$(VER)-it-TEST
TGZ_OUTPUT := pg$(MAJORVER).tar.gz
ZIP_OUTPUT := pg$(MAJORVER).zip
PDF_OUTPUT := pg$(MAJORVER).pdf
QUICKPDF_OUTPUT := quickpg$(MAJORVER).pdf
MAN_OUTPUT := pg$(MAJORVER).man.tar.gz
CHM_OUTPUT := pg$(MAJORVER).chm.tar.gz
NOCHUNKS_OUTPUT := pg$(MAJORVER).html

CHUNK_QUIET=0
VPATH = $(BASEDIR):$(BASEDIR)/ref
src = *.xml ref/*.xml
srctest = test.xml

all: xsl html webhtml pdf manpages INSTALL.html INSTALL.txt

dumbo: xsl html webhtml manpages INSTALL.html INSTALL.txt

xsl: ../stylesheets/pg-chm.xsl.in
	echo "Creazione degli stylesheet"
	../bin/prepara-xsl.sh $(XSLROOTDIR)

html: index.html
index.html: $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc --xinclude --nonet -stringparam profile.condition html \
		-stringparam  profile.attribute  "standalone" -stringparam  profile.value  "no" \
		-stringparam chunk.quietly $(CHUNK_QUIET) \
		-stringparam use.id.as.filename "yes" \
		-stringparam base.dir $(BASEDIR)/$(HTM_OUTPUT)/ \
		../stylesheets/pg-chunked.xsl postgres.xml

	[ -d $(BASEDIR)/$(HTM_OUTPUT)/stylesheets ] || mkdir $(BASEDIR)/$(HTM_OUTPUT)/stylesheets
	cp ../stylesheets/*.css $(BASEDIR)/$(HTM_OUTPUT)/stylesheets

	[ -d $(BASEDIR)/$(HTM_OUTPUT)/images ] || mkdir $(BASEDIR)/$(HTM_OUTPUT)/images
	cp ../stylesheets/img/*.png $(BASEDIR)/$(HTM_OUTPUT)/images
	cd $(BASEDIR)/$(HTM_OUTPUT)/; sed -i -e "s@../stylesheets@stylesheets@g" *.html
	cd $(BASEDIR)/$(HTM_OUTPUT)/; sed -i -e "s@../images@images@g" *.html

	for filename in `find $(BASEDIR)/$(HTM_OUTPUT) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;

	cd $(BASEDIR); tar cfz $(TGZ_OUTPUT) $(HTM_OUTPUT)
	cd $(BASEDIR); zip -r $(ZIP_OUTPUT) $(HTM_OUTPUT)
	mv $(BASEDIR)/$(TGZ_OUTPUT) $(BASEDIR)/$(ZIP_OUTPUT) $(BASEDIR)/$(HTM_OUTPUT)

	rm -f $(BASEDIR)/$(HTM_OUTPUT)/*.html
	rm -rf $(BASEDIR)/$(HTM_OUTPUT)/images
	rm -rf $(BASEDIR)/$(HTM_OUTPUT)/prologue
	rm -rf $(BASEDIR)/$(HTM_OUTPUT)/stylesheets

webhtml: $(src)
	[ -d $(BASEDIR)/$(WEB_OUTPUT) ] || mkdir -p $(BASEDIR)/$(WEB_OUTPUT)
	xsltproc --xinclude --nonet -stringparam profile.condition html \
		-stringparam  profile.attribute  "standalone" -stringparam  profile.value  "no" \
		-stringparam chunk.quietly $(CHUNK_QUIET) \
		-stringparam use.id.as.filename "yes" \
		-stringparam base.dir $(BASEDIR)/$(WEB_OUTPUT)/ \
		../stylesheets/pg-chunked-web.xsl postgres.xml 

	[ -d $(BASEDIR)/$(WEB_OUTPUT)/stylesheets ] || mkdir $(BASEDIR)/$(WEB_OUTPUT)/stylesheets
	cp ../stylesheets/*.css $(BASEDIR)/$(WEB_OUTPUT)/stylesheets

	[ -d $(BASEDIR)/$(WEB_OUTPUT)/images ] || mkdir $(BASEDIR)/$(WEB_OUTPUT)/images
	cp ../stylesheets/img/*.png $(BASEDIR)/$(WEB_OUTPUT)/images
	cd $(BASEDIR)/$(WEB_OUTPUT)/; sed -i -e "s@../stylesheets@stylesheets@g" *.html
	cd $(BASEDIR)/$(WEB_OUTPUT)/; sed -i -e "s@\.\./images@images@g" *.html
	cd $(BASEDIR)/$(WEB_OUTPUT)/; sed -i -e 's@border="1"@border="0"@g' *.html

	for filename in `find $(BASEDIR)/$(WEB_OUTPUT) -name "*.html"`; do \
	  tidy -config tidy.conf $$filename; \
	  true; \
	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
	done;
	cd $(BASEDIR)/$(WEB_OUTPUT)/; sed -i -e "s@</head>@<script type=\"text/javascript\"> var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-11269384-3']); _gaq.push(['_trackPageview']); (function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })(); </script></head>@g" *.html

webtest: $(srctest)
	[ -d $(BASEDIR)/$(WEBTEST_OUTPUT) ] || mkdir -p $(BASEDIR)/$(WEBTEST_OUTPUT)
	xsltproc --xinclude --nonet -stringparam profile.condition html \
		-stringparam  profile.attribute  "standalone" -stringparam  profile.value  "no" \
		-stringparam chunk.quietly $(CHUNK_QUIET) \
		-stringparam use.id.as.filename "yes" \
		-stringparam base.dir $(BASEDIR)/$(WEBTEST_OUTPUT)/ \
		../stylesheets/pg-chunked-web.xsl test.xml

	[ -d $(BASEDIR)/$(WEBTEST_OUTPUT)/stylesheets ] || mkdir $(BASEDIR)/$(WEBTEST_OUTPUT)/stylesheets
	cp ../stylesheets/*.css $(BASEDIR)/$(WEBTEST_OUTPUT)/stylesheets

	[ -d $(BASEDIR)/$(WEBTEST_OUTPUT)/images ] || mkdir $(BASEDIR)/$(WEBTEST_OUTPUT)/images
	cp ../stylesheets/img/*.png $(BASEDIR)/$(WEBTEST_OUTPUT)/images
	cd $(BASEDIR)/$(WEBTEST_OUTPUT)/; sed -i -e "s@../stylesheets@stylesheets@g" *.html
	cd $(BASEDIR)/$(WEBTEST_OUTPUT)/; sed -i -e "s@\.\./images@images@g" *.html
	cd $(BASEDIR)/$(WEBTEST_OUTPUT)/; sed -i -e 's@border="1"@border="0"@g' *.html

#	for filename in `find $(BASEDIR)/$(WEB_OUTPUT) -name "*.html"`; do \
#	  tidy -config tidy.conf $$filename; \
#	  true; \
#	  sed -i -e "s@text/html@application/xhtml+xml@g" $$filename; \
#	done;
	cd $(BASEDIR)/$(WEBTEST_OUTPUT)/; sed -i -e "s@</head>@<script type=\"text/javascript\"> var _gaq = _gaq || []; _gaq.push(['_setAccount', 'UA-11269384-3']); _gaq.push(['_trackPageview']); (function() { var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true; ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js'; var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s); })(); </script></head>@g" *.html

pdf: $(PDF_OUTPUT)
$(PDF_OUTPUT): $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc --xinclude --nonet --stringparam profile.condition pdf \
                -stringparam  profile.attribute  "standalone" -stringparam  profile.value  "no" \
		--output $(BASEDIR)/pg-pdf.xml ../stylesheets/pg-profile.xsl postgres.xml
	xsltproc --nonet --output $(BASEDIR)/pg-pdf.fo ../stylesheets/pg-pdf.xsl \
		$(BASEDIR)/pg-pdf.xml
	sed -i -e "s/inherit/all/" $(BASEDIR)/pg-pdf.fo
	sed -i -e "s/xml.apache.org/xmlgraphics.apache.org/g" $(BASEDIR)/pg-pdf.fo
	fop $(BASEDIR)/pg-pdf.fo $(BASEDIR)/$(HTM_OUTPUT)/$(PDF_OUTPUT)
	rm $(BASEDIR)/pg-pdf.xml $(BASEDIR)/pg-pdf.fo


quickpdf: $(QUICKPDF_OUTPUT)
$(QUICKPDF_OUTPUT): $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc --xinclude --nonet --stringparam profile.condition pdf \
                -stringparam  profile.attribute  "standalone" -stringparam  profile.value  "no" \
		--output $(BASEDIR)/pg-pdf.xml ../stylesheets/pg-profile.xsl gettingstarted.xml
	xsltproc --nonet --output $(BASEDIR)/pg-pdf.fo ../stylesheets/quickpg-pdf.xsl \
		$(BASEDIR)/pg-pdf.xml
	sed -i -e "s/inherit/all/" $(BASEDIR)/pg-pdf.fo
	fop.sh $(BASEDIR)/pg-pdf.fo $(BASEDIR)/$(HTM_OUTPUT)/$(PDF_OUTPUT)
	#rm $(BASEDIR)/pg-pdf.xml $(BASEDIR)/pg-pdf.fo

nochunks: $(NOCHUNKS_OUTPUT)
$(NOCHUNKS_OUTPUT): $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc --xinclude --nonet -stringparam profile.condition html \
		--output $(BASEDIR)/$(NOCHUNKS_OUTPUT) \
		../stylesheets/pg-nochunks.xsl postgres.xml

	tidy -config tidy.conf $(BASEDIR)/$(NOCHUNKS_OUTPUT) || true

	sed -i -e "s@text/html@application/xhtml+xml@g"  \
	  $(BASEDIR)/$(NOCHUNKS_OUTPUT)

validate:
	xmllint --noout --nonet --xinclude --postvalid postgres.xml

INSTALL.html: $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc --xinclude --nonet -stringparam profile.condition html \
                --stringparam  profile.attribute  "standalone" --stringparam  profile.value  "yes" \
		--output $(BASEDIR)/$(HTM_OUTPUT)/INSTALL.html \
		../stylesheets/pg-nochunks.xsl standalone-install.xml

	tidy -config tidy.conf $(BASEDIR)/$(HTM_OUTPUT)/INSTALL.html || true

	sed -i -e "s@text/html@application/xhtml+xml@g"  \
	  $(BASEDIR)/$(HTM_OUTPUT)/INSTALL.html


INSTALL.txt: INSTALL.html
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	html2text -nobs -style pretty $(BASEDIR)/$(HTM_OUTPUT)/INSTALL.html > $(BASEDIR)/$(HTM_OUTPUT)/INSTALL.txt

manpages: psql.1
psql.1: $(src)
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	xsltproc $(XSLROOTDIR)/manpages/docbook.xsl \
		standalone-manpages.xml
	[ -d man/man1 ] || mkdir -p man/man1
	[ -d man/man7 ] || mkdir -p man/man7
	mv *.1 man/man1
	mv *.7 man/man7
	tar cvfz $(BASEDIR)/$(HTM_OUTPUT)/$(MAN_OUTPUT) man
	rm -r man

htmlhelp:
	[ -d $(BASEDIR)/$(HTM_OUTPUT) ] || mkdir -p $(BASEDIR)/$(HTM_OUTPUT)
	[ -d chm ] || mkdir chm
	xsltproc ../stylesheets/pg-chm.xsl postgres.xml
	mv *.h?? chm
	tar cvfz $(BASEDIR)/$(HTM_OUTPUT)/$(CHM_OUTPUT) chm
