# define budgets to notify based on various conditions to enforce aws monthly spend

resource "aws_budgets_budget" "overall_budget" {
  name         = "overall budget"
  budget_type  = "COST"
  limit_amount = 100
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  notification {
    comparison_operator        = "EQUAL_TO"
    notification_type          = "FORECASTED"
    threshold                  = 75
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["nathan@nfowler.dev"]
  }
  notification {
    comparison_operator        = "EQUAL_TO"
    notification_type          = "ACTUAL"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    subscriber_email_addresses = ["nathan@nfowler.dev"]
  }
}

