variable "bot_name" {
  type        = string
  description = "Bot Name"

  default = "bot_default_name_appointment_doctor"
}

variable "bot_description" {
  type        = string
  description = "Bot Description"

  default = "bot_default_description_appointment_doctor"
}

variable "find_doctor_intent_utterance" {
  type = list(string)
  description = "Utterance of bot"

  default = [
    "I need a doctor",
    "Find me a doctor",
    "Get me a doc",
    "Can you recommend a doctor"
  ]
}
