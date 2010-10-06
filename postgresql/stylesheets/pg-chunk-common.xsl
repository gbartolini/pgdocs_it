<?xml version="1.0" encoding="iso8859-15"?>
<!--This file was created automatically by html2xhtml-->
<!--from the HTML stylesheets.-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:cf="http://docbook.sourceforge.net/xmlns/chunkfast/1.0" xmlns:ng="http://docbook.org/docbook-ng" xmlns:db="http://docbook.org/ns/docbook" xmlns="http://www.w3.org/1999/xhtml" version="1.0" exclude-result-prefixes="exsl cf ng db">

<xsl:template name="chunk-element-content">
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <xsl:param name="nav.context"/>
    <xsl:param name="content">
        <xsl:apply-imports/>
    </xsl:param>

    <xsl:call-template name="user.preroot"/>

<html>
    <xsl:call-template name="html.head">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>

    <body>
        <xsl:call-template name="body.attributes"/>

        <div id="header">
            <div id="header_sx">
                <a href="http://www.postgresql.org" title="PostgreSQL"><img src="http://www.postgresql.org/layout/images/docs/hdr_logo.png" width="206" height="80" alt="PostgreSQL" /></a>
            </div>
            <div id="header_dx">
                <a href="http://www.itpug.org" title="ITPUG Italian PostgreSQL Users"><img src="images/logo.png" /></a>
            </div>
            <br style="clear:both;" />
        </div>



    
    <div id="content">
        <xsl:call-template name="upper.navigation">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="nav.context" select="$nav.context"/>
        </xsl:call-template>

        <xsl:copy-of select="$content"/>
      
        <xsl:call-template name="lower.navigation">
            <xsl:with-param name="prev" select="$prev"/>
            <xsl:with-param name="next" select="$next"/>
            <xsl:with-param name="nav.context" select="$nav.context"/>
        </xsl:call-template>
    </div>



   
    <div id="footer">
        <p style="float:left;">
            Copyright © 1996 - 2010 PostgreSQL Global Development Group<br />
            Copyright © 2010 Italian PostgreSQL Users Group<br />
            <a href="http://www.itpug.org/privacy/index.it.html">Privacy</a> | <a href="http://www.itpug.org/thanks/index.it.html">Ringraziamenti</a>
        </p>
        <p style="float:right;">
            Powered by<br /> 
            <a href="http://www.2ndquadrant.it">
            <img src="images/2ndQuadrant-logo.png" 
                alt="2ndQuadrant" 
                width="256" 
                height="52" />
            </a>
        </p>
        <br style="clear:both;" />
    </div>


</body>
</html>

<xsl:value-of select="$chunk.append"/>
</xsl:template>

</xsl:stylesheet>
