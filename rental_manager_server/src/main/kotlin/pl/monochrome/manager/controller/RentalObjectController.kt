package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.RentalObjectDto
import pl.monochrome.manager.service.db.RentalObjectService

@RestController
@RequestMapping("/rentalobjects")

class RentalObjectController @Autowired constructor(val service: RentalObjectService) {

    @GetMapping
    fun getRentalObjectsForUser(@RequestParam userId: String) = service.getRentalObjectsForUser(userId)

    @PostMapping
    fun addRentalObject(@RequestBody rentalObjectDto: RentalObjectDto) = service.addRentalObject(rentalObjectDto)

    @PutMapping
    fun updateRentalObject(@RequestBody rentalObjectDto: RentalObjectDto) = service.updateRentalObject(rentalObjectDto)

    @GetMapping("/{rentalObjectId}")
    fun getRentalObject(@PathVariable rentalObjectId: Int) = service.getRentalObject(rentalObjectId)

    @DeleteMapping("/{rentalObjectId}")
    fun deleteRentalObject(@PathVariable rentalObjectId: Int) = service.deleteRentalObject(rentalObjectId)

}