resource "aws_lex_intent" "find_doctor" {

  create_version = false
  name           = "FindADoctor"
  description    = "Intent to to search for doctors on certain city based on specialty"

  sample_utterances = var.find_doctor_intent_utterance

  confirmation_prompt {
    max_attempts = 2

    message {
      content      = "Okay, doctor searched and added. Dr will contact you soon. Have a great day. Bye :)"
      content_type = "PlainText"
    }
  }

  rejection_statement {
    message {
      content      = "Well, I will cancelled."
      content_type = "PlainText"
    }
  }

  # Start: Slots Definition
  slot {
    description       = aws_lex_slot_type.doctor_specialty.description
    name              = aws_lex_slot_type.doctor_specialty.name
    priority          = 2
    slot_constraint   = "Required"
    slot_type         = aws_lex_slot_type.doctor_specialty.name
    slot_type_version = aws_lex_slot_type.doctor_specialty.version

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content      = "What doctor do you need?"
        content_type = "PlainText"
      }
    }
  }

  slot {
    description = "City in which the doctor will attend"
    name        = "DoctorCity_diego_jauregui"
    priority    = 2

    slot_constraint = "Required"
    slot_type       = "AMAZON.US_CITY"

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content      = "In wich city do you need a doctor?"
        content_type = "PlainText"
      }
    }
  }

  # End: Slots Definition

  fulfillment_activity {
    type = "ReturnIntent"
  }
}
