package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.GuestDto
import pl.monochrome.manager.service.db.GuestService

@RestController
@RequestMapping("/guests")
class GuestController @Autowired constructor(private val service: GuestService) {

    @GetMapping
    fun getGuestsForUser(@RequestParam userId: String) = service.getAllGuests(userId)

    @PostMapping
    fun addGuest(@RequestBody guestDto: GuestDto) = service.addGuest(guestDto)

    @PutMapping
    fun updateGuest(@RequestBody guestDto: GuestDto) = service.updateGuest(guestDto)

    @DeleteMapping("/{personId}")
    fun deleteGuest(@PathVariable personId: Int, @RequestParam userId: String) = service.deleteGuest(userId, personId)

    @GetMapping("/{personId}")
    fun getGuest(@RequestParam userId: String, @PathVariable personId: Int) = service.getGuest(userId, personId)

}