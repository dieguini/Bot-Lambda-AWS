resource "aws_lex_bot" "bot_appointment_doctor" {
  abort_statement {
    message {
      content      = "Sorry, I could not understand. Goodbye."
      content_type = "PlainText"
    }
  }

  child_directed = false

  clarification_prompt {
    max_attempts = 2

    message {
      content      = "Sorry, can you please repeat that?"
      content_type = "PlainText"
    }
  }

  create_version              = false
  description                 = var.bot_description
  idle_session_ttl_in_seconds = 600

  locale           = "en-US"
  name             = var.bot_name
  process_behavior = "SAVE"
  voice_id         = "Joanna"

  intent {
    intent_name    = aws_lex_intent.find_doctor.name
    intent_version = aws_lex_intent.find_doctor.version
  }
}