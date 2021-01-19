# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/master/containers/java/.devcontainer/base.Dockerfile
ARG JAVA_VERSION=8
ARG INSTALL_NODE="false"
FROM mcr.microsoft.com/vscode/devcontainers/java:0-${JAVA_VERSION}


# Install Maven or Gradle
ARG MAVEN_VERSION=3.6.3
ARG GRADLE_VERSION=6.8
ARG SCALA_VERSION=2.12.12
RUN su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install maven \"${MAVEN_VERSION}\"" \
    && su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install gradle \"${GRADLE_VERSION}\"" \
    && su vscode -c "source /usr/local/sdkman/bin/sdkman-init.sh && sdk install sbt"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends\
    curl \
    make \
    gnupg \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace

# prepare sbt (warming cache)
ARG SBT_VERSION=1.4.6
RUN chown vscode:vscode /workspace \
    && su vscode -c \
    "source /usr/local/sdkman/bin/sdkman-init.sh \
    && sbt sbtVersion \
    && mkdir -p project \
    && echo \"scalaVersion := \\\"${SCALA_VERSION}\\\" \" > build.sbt \
    && echo \"sbt.version=${SBT_VERSION}\" > project/build.properties \
    && echo \"case object Temp\" > Temp.scala \
    && sbt compile \
    && rm -r project target \
    && rm build.sbt Temp.scala"

USER vscode