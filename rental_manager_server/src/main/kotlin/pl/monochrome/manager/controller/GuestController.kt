package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.service.GuestService
import java.util.*

@RestController
@RequestMapping("/guests")
class GuestController @Autowired constructor(private val service: GuestService) {

    @GetMapping
    fun getGuests(@RequestParam id: UUID) = service.getAllGuests(id)

    @GetMapping("/{id}")
    fun getGuest(@RequestParam("userId")userId: UUID, @PathVariable("id")id: UUID) = service.getGuest(userId, id)

}