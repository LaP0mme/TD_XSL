<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="film.css"/>
                <title>cinématographie</title>
                <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
                <script src="scroll.js"> </script>
                <link rel="stylesheet" type="text/css" href="scroll.css"/>
            </head>
            <body>
                <div id="main">
                    <section>
                        <h1>Table Des matières</h1>
                        <xsl:apply-templates select="films/film" mode="tdm">
                        </xsl:apply-templates>
                    </section>
                    <section>
                        <h2>Table Des matières des acteurs</h2>
                        <xsl:apply-templates select="films/film/acteurDescription">
                        </xsl:apply-templates>
                    </section>
                    <xsl:apply-templates select="films/film" mode="complet">
                        <xsl:sort select="@annee" order="descending" data-type="number"/>
                    </xsl:apply-templates>
                </div>
                <script>
                    $("#main").onepage_scroll({
                    sectionContainer: "section",
                    easing: "ease",
                    animationTime: 1000,
                    pagination: true,
                    updateURL: false,
                    beforeMove: function(index) {},
                    afterMove: function(index) {},
                    loop: false,
                    keyboard: true,
                    responsiveFallback: false
                    });
                    function tdm(id){
                    $(".main").moveTo(id + 2);
                    }
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <section>
            <xsl:if test="@annee = '2023'">
                <h4 class="nouveaute">Nouveauté</h4>
            </xsl:if>
            <h2>
                <xsl:variable name="url" select="image/@url"/>
                <img src="{$url}"/>
                <xsl:text></xsl:text>
                <a>
                    <xsl:attribute name="name">
                        <xsl:value-of select="titre"/>
                    </xsl:attribute>
                    <xsl:value-of select="titre"/>
                    <!-- on affiche l'image grace a l'url -->
                </a>
            </h2>
            <i>Film
                <xsl:value-of select="nationalite"/>
                de<xsl:value-of select="duree"/>min sortie en
                <xsl:value-of select="@annee"/>
            </i>
            <p>* Réalisé par
                <xsl:value-of select="realisateur"/>
                *
            </p>
            <h3>Acteurs :</h3>
            <ul>
                <xsl:apply-templates select="acteurs/acteur"/>
            </ul>
            <p class="histoireType">
                <xsl:apply-templates select="scenario"/>
            </p>
            <h3>Genres :</h3>
            <ul>
                <xsl:for-each select="genres">
                    <li>
                        <xsl:value-of select="."/>
                    </li>
                </xsl:for-each>
            </ul>
        </section>
    </xsl:template>

    <xsl:template match="scenario/ev">
        <i>
            <xsl:value-of select="."/>
        </i>
    </xsl:template>
    <xsl:template match="scenario/personnage">
        <b>
            <xsl:value-of select="."/>
        </b>
    </xsl:template>
    <xsl:template match="film" mode="tdm">
        <ul>
            <li>
                <h3>
                    <a>
                        <xsl:attribute name="href">#
                            <xsl:value-of select="position()"/>
                        </xsl:attribute>
                        <xsl:value-of select="titre"/>
                    </a>
                </h3>
                <i>(Nombre d'acteurs =
                    <xsl:value-of select="count(acteurs/acteur)"/>
                    :
                    <xsl:value-of select="acteurs"/>)
                </i>
                [ <xsl:apply-templates select="scenario/keyword"/> ]
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="acteurDescription">
        <ul>
            <li>
                <i>
                    <xsl:value-of select="prenom"/>
                    <xsl:text></xsl:text>
                    <xsl:value-of select="nom"/>
                    <xsl:text>né le</xsl:text>
                    <xsl:value-of select="dateNaissance"/>
                    <!-- On compte le nombre de films dans lequel l'acteur a joué -->
                    <xsl:variable name="idActeur" select="@id"/>
                    à joué dans
                    <xsl:value-of select="count(//film/acteurs/acteur[@ref=$idActeur])"/>
                    film(s)
                </i>
            </li>
        </ul>
    </xsl:template>

    <xsl:template match="acteurs/acteur">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

    <xsl:template match="scenario/keyword">
       <xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
