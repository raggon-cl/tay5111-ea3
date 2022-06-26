# This resource will destroy (potentially immediately) after null_resource.next
#resource "null_resource" "previous" {}

resource "time_sleep" "wait_330_seconds" {
  #  depends_on = [null_resource.previous]

  create_duration = "330s"
}


