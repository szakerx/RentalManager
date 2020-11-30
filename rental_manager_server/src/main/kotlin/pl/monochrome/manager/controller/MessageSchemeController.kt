package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.service.MessageSchemeService
import java.util.*

@RestController
@RequestMapping("/schemes")
class MessageSchemeController @Autowired constructor(private val service: MessageSchemeService) {

    @GetMapping
    fun getAllMessageSchemes(@RequestParam userId: UUID) = service.getAllSchemasForUser(userId)

    @GetMapping("/{id}")
    fun getMessageSchema(@PathVariable messageSchemeId: UUID) = service.getMessageScheme(messageSchemeId)
}