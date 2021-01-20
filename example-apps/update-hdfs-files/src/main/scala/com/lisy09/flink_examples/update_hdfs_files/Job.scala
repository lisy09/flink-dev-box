package com.lisy09.flink_examples.update_hdfs_files

import org.apache.flink.core.fs.Path
import org.apache.flink.api.common.serialization.SimpleStringEncoder
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment
import org.apache.flink.streaming.api.functions.sink.filesystem.StreamingFileSink
import org.apache.flink.streaming.api.functions.sink.filesystem.rollingpolicies.DefaultRollingPolicy
import java.util.concurrent.TimeUnit
import org.apache.flink.streaming.api.functions.sink.filesystem.BucketAssigner
import org.apache.flink.streaming.api.functions.sink.filesystem.bucketassigners.SimpleVersionedStringSerializer
import org.apache.flink.core.io.SimpleVersionedSerializer
import org.apache.flink.streaming.api.environment.CheckpointConfig.ExternalizedCheckpointCleanup
import java.text.SimpleDateFormat
import org.apache.flink.streaming.api.functions.sink.filesystem.OutputFileConfig
import scopt.OptionParser

class EventTimeBucketAssigner extends BucketAssigner[Record, String] {
  val datetimeFormatter = new SimpleDateFormat("'year='yyyy'/month='MM'/day='dd'/hour='HH")
  override def getBucketId(element: Record, context: BucketAssigner.Context): String = {
    val id = datetimeFormatter.format(element.timestamp)
    id
  }

  override def getSerializer(): SimpleVersionedSerializer[String] = {
    SimpleVersionedStringSerializer.INSTANCE;
  }
}

case class Config(
  basePath: String = "/workspace/data",
)
object Config {
  def build(args: Array[String]): Config = {
    val configParser = new OptionParser[Config]("update_hdfs_files") {
        head("update_hdfs_files", "0.1")
        opt[String]("basePath")
          // .required()
          .action((x,c) => c.copy(basePath = x))
          .text("basePath is the base url to store the data")
    }
    var conf = new Config()
    configParser.parse(args, conf) map { config =>
        conf = config
    } getOrElse {
        sys.exit(1)
    }
    return conf
  }
}

object Job {
  def main(args: Array[String]): Unit = {
    val conf = Config.build(args)
    println(conf)

    val rollingPolicy = DefaultRollingPolicy
      .builder()
      .withMaxPartSize(1024*1024*10) // 10M
      .withRolloverInterval(TimeUnit.MINUTES.toMillis(3)) // 3min
      .withInactivityInterval(TimeUnit.SECONDS.toMillis(60) ) //60s
      .build[Record,String]()
    val hdfsSink = StreamingFileSink
      .forRowFormat(new Path(conf.basePath), new SimpleStringEncoder[Record]("UTF-8"))
      .withBucketAssigner(new EventTimeBucketAssigner())
      .withRollingPolicy(rollingPolicy)
      .build()

    // set up the execution environment
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    env.enableCheckpointing(60000)
    env.getCheckpointConfig().enableExternalizedCheckpoints(
      ExternalizedCheckpointCleanup.DELETE_ON_CANCELLATION);
    env.setParallelism(3)

    val stream = env.addSource(new DataSource())
    stream.addSink(hdfsSink)

    env.execute()
  }
}
