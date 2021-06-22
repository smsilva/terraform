module "buckets" {
    source = "../publish_bucket"
    
    for_each = toset(["assets", "media", "demo"])
    name = "${each.key}"
}