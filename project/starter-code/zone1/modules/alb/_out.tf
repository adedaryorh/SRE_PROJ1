output "id" {
  value = aws_alb.alb.id
}
output "dns_name" {
  value = aws_alb.alb.dns_name
}
output "sg_id" {
  value = aws_security_group.sg.id
}
output "aws_alb_target_group" {
  value = aws_alb_target_group.app_tg.arn
}