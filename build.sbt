organization := "com.github.biopet"
organizationName := "Biowdl"
name := "RNA-seq"

biopetUrlName := "RNA-seq"

startYear := Some(2018)

biopetIsTool := false
biopetIsPipeline := true

concurrentRestrictions := Seq(
  Tags.limitAll(
    Option(System.getProperty("biowdl.threads")).map(_.toInt).getOrElse(1)),
  Tags.limit(Tags.Compile, java.lang.Runtime.getRuntime.availableProcessors())
)

developers ++= List(
  Developer(id = "ffinfo",
            name = "Peter van 't Hof",
            email = "pjrvanthof@gmail.com",
            url = url("https://github.com/ffinfo")),
  Developer(id = "DavyCats",
            name = "Davy Cats",
            email = "d.cats@lumc.nl",
            url = url("https://github.com/DavyCats"))
)

scalaVersion := "2.11.12"

libraryDependencies += "com.github.biopet" %% "biowdl-test-utils" % "0.2-SNAPSHOT" % Test changing ()
libraryDependencies += "com.github.biopet" %% "ngs-utils" % "0.4"
