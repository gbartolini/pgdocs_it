<?xml version='1.0' encoding='ISO-8859-1'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

    <!-- Dropping the HEAD links -->
  <xsl:template name="html.head">
    <head>
      <xsl:call-template name="system.head.content"/>
      <xsl:call-template name="head.content"/>
      <xsl:call-template name="user.head.content"/>
    </head>
  </xsl:template>




<!-- Manual Navigation -->
<xsl:template name="upper.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>
    <xsl:variable name="row" select="count($prev) &gt; 0 or count($up) &gt; 0
        or count($next) &gt; 0 or generate-id($home) != generate-id(.)"/>
    <xsl:if test="$row">
    <div class="upper_navigation">
        <table summary="Barra di navigazione">
	        <tr>
	            <td>
                    <xsl:call-template name="user.header.content"/>
                </td>
	            <td></td>
	        </tr>
            <tr>
            <!-- Precedente -->
            <td>
            <xsl:if test="count($prev)&gt;0 and $prev != $home">
                <a accesskey="p">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$prev"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="$prev/refmeta/refentrytitle != ''">
                            <xsl:value-of select="$prev/refmeta/refentrytitle"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$prev/title"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <img src="images/prev.png" alt="Precedente" />
                <xsl:choose>
                    <xsl:when test="$prev/refmeta/refentrytitle != ''">
                        <xsl:value-of select="$prev/refmeta/refentrytitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$prev/title"/>
                    </xsl:otherwise>
                </xsl:choose>
                </a>
            </xsl:if>
            </td>
            <!-- Successivo -->
            <td class="dx">
            <xsl:if test="count($next)&gt;0">
                <a accesskey="n">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$next"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="local-name($next)='index'">
                            <xsl:call-template name="gentext">
                                <xsl:with-param name="key">Index</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$next/refmeta/refentrytitle != ''">
                            <xsl:value-of select="$next/refmeta/refentrytitle"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$next/title"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="local-name($next)='index'">
                        <xsl:call-template name="gentext">
                            <xsl:with-param name="key">Index</xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$next/refmeta/refentrytitle != ''">
                        <xsl:value-of select="$next/refmeta/refentrytitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$next/title"/>
                    </xsl:otherwise>
                </xsl:choose>
                <img src="images/next.png" alt="Successivo" />
                </a>
            </xsl:if>
            </td>
        </tr>
        </table>
    </div>
    </xsl:if>
</xsl:template>
<xsl:template name="lower.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:param name="nav.context"/>
    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>
    <xsl:variable name="row" select="count($prev) &gt; 0 or count($up) &gt; 0
        or count($next) &gt; 0 or generate-id($home) != generate-id(.)"/>
    <xsl:if test="$row">
    <div class="lower_navigation">
        <table summary="Barra di navigazione">
	        <tr>
	            <td>
                    <xsl:call-template name="user.header.content"/>
                </td>
	            <td></td>
	        </tr>
            <tr>
            <!-- Precedente -->
            <td>
            <xsl:if test="count($prev)&gt;0 and $prev != $home">
                <a accesskey="p">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$prev"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="$prev/refmeta/refentrytitle != ''">
                            <xsl:value-of select="$prev/refmeta/refentrytitle"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$prev/title"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <img src="images/prev.png" alt="Precedente" />
                <xsl:choose>
                    <xsl:when test="$prev/refmeta/refentrytitle != ''">
                        <xsl:value-of select="$prev/refmeta/refentrytitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$prev/title"/>
                    </xsl:otherwise>
                </xsl:choose>
                </a>
            </xsl:if>
            </td>
            <!-- Successivo -->
            <td class="dx">
            <xsl:if test="count($next)&gt;0">
                <a accesskey="n">
                <xsl:attribute name="href">
                    <xsl:call-template name="href.target">
                        <xsl:with-param name="object" select="$next"/>
                    </xsl:call-template>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="local-name($next)='index'">
                            <xsl:call-template name="gentext">
                                <xsl:with-param name="key">Index</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$next/refmeta/refentrytitle != ''">
                            <xsl:value-of select="$next/refmeta/refentrytitle"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$next/title"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="local-name($next)='index'">
                        <xsl:call-template name="gentext">
                            <xsl:with-param name="key">Index</xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$next/refmeta/refentrytitle != ''">
                        <xsl:value-of select="$next/refmeta/refentrytitle"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$next/title"/>
                    </xsl:otherwise>
                </xsl:choose>
                <img src="images/next.png" alt="Successivo" />
                </a>
            </xsl:if>
            </td>
        </tr>
        </table>
    </div>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
