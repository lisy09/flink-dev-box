package com.lisy09.flink_examples.update_hdfs_files


import org.apache.flink.streaming.api.functions.source.RichParallelSourceFunction
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment
import org.apache.flink.streaming.api.functions.source.SourceFunction.SourceContext
import java.util.Calendar
import scala.util.Random
import org.json4s._
import org.json4s.JsonDSL._
import org.json4s.jackson.JsonMethods._

trait RecordToString { this:Record =>
  override def toString(): String = {
    val json = (
      ("timestamp" -> this.timestamp) ~
      ("key" -> this.key) ~
      ("value" -> this.value)
    )
    val jsonStr = compact(render(json))
    return jsonStr
  }
}

case class Record(
  timestamp: Long,
  key: Int,
  value: Int,
) extends RecordToString

class DataSource extends RichParallelSourceFunction[Record] {
  var running: Boolean = true

  override def cancel(): Unit = running = false

  override def run(ctx: SourceContext[Record]) {
    val rand = new Random(System.currentTimeMillis())
    while (running) {
      Thread.sleep((getRuntimeContext().getIndexOfThisSubtask() + 1)*1000 + 500)
      val currentTime = Calendar.getInstance().getTimeInMillis()
      ctx.collect(Record(
        timestamp = currentTime,
        key = rand.nextInt(10),
        value = rand.nextInt(10),
      ))
    }
  }
}

object TestDataSource {
  def main(args: Array[String]): Unit = {
    // set up the execution environment
    val env = StreamExecutionEnvironment.getExecutionEnvironment
    env.setParallelism(1)

    val stream = env.addSource(new DataSource())
    stream.print()

    // execute program
    env.execute()
  }
}

