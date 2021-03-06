package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.MessageSchemeDto
import pl.monochrome.manager.service.db.MessageSchemeService

@RestController
@RequestMapping("/schemes")
class MessageSchemeController @Autowired constructor(private val service: MessageSchemeService) {

    @GetMapping
    fun getAllMessageSchemes(@RequestParam userId: String) = service.getAllSchemasForUser(userId)

    @PostMapping
    fun addMessageScheme(@RequestBody messageSchemeDto: MessageSchemeDto) = service.addMessageScheme(messageSchemeDto)

    @PutMapping
    fun updateMessageScheme(@RequestBody messageSchemeDto: MessageSchemeDto) = service.updateMessageScheme(messageSchemeDto)

    @GetMapping("/{messageSchemeId}")
    fun getMessageSchema(@PathVariable messageSchemeId: Int) = service.getMessageScheme(messageSchemeId)

    @DeleteMapping("/{messageSchemeId}")
    fun deleteMessageScheme(@PathVariable messageSchemeId: Int) = service.deleteMessageScheme(messageSchemeId)

}