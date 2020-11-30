package pl.monochrome.manager.model.dto

import java.util.*

data class MessageSchemeDTO(val id: UUID, val name: String, val content: String, val userId: UUID)
