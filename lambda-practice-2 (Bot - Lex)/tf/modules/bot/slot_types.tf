resource "aws_lex_slot_type" "doctor_specialty" {
  enumeration_value {
    synonyms = [
      "Pediat",
    ]

    value = "Pediatrician"
  }

  enumeration_value {
    synonyms = [
      "Cardio",
    ]

    value = "Cardiologist"
  }

  enumeration_value {
    synonyms = [
      "Orthopedic",
    ]

    value = "Orthop"
  }

  enumeration_value {
    synonyms = [
      "Neuto",
    ]

    value = "Neurologist"
  }

  name                     = "DoctorSpecialty_diego_jauregui"
  value_selection_strategy = "ORIGINAL_VALUE"
  create_version = true
  description    = "List of doctor specialtist"
}