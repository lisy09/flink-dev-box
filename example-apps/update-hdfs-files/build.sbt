ThisBuild / resolvers ++= Seq(
    "Apache Development Snapshot Repository" at "https://repository.apache.org/content/repositories/snapshots/",
    Resolver.mavenLocal
)

name := "update-hdfs-files"

version := "0.1-SNAPSHOT"

organization := "com.lisy09.flink_examples.update_hdfs_files"

ThisBuild / scalaVersion := "2.12.12"

val flinkVersion = "1.12.1"

val flinkDependencies = Seq(
  "org.apache.flink" %% "flink-clients" % flinkVersion % "provided",
  "org.apache.flink" %% "flink-scala" % flinkVersion % "provided",
  "org.apache.flink" %% "flink-streaming-scala" % flinkVersion % "provided",
  // "org.apache.flink" %% "flink-connector-filesystem" % "1.11.3",
  "org.json4s" %% "json4s-native" % "3.6.10",
  "org.json4s" %% "json4s-jackson" % "3.6.10",
  "com.github.scopt" %% "scopt" % "4.0.0",
)

lazy val root = (project in file(".")).
  settings(
    libraryDependencies ++= flinkDependencies
  )

assembly / mainClass := Some("com.lisy09.flink_examples.update_hdfs_files.Job")

// make run command include the provided dependencies
Compile / run  := Defaults.runTask(Compile / fullClasspath,
                                   Compile / run / mainClass,
                                   Compile / run / runner
                                  ).evaluated

// stays inside the sbt console when we press "ctrl-c" while a Flink programme executes with "run" or "runMain"
Compile / run / fork := true
Global / cancelable := true

// exclude Scala library from assembly
assembly / assemblyOption  := (assembly / assemblyOption).value.copy(includeScala = false)
