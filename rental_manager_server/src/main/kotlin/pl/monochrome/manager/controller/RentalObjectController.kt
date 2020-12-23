package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*
import pl.monochrome.manager.model.dto.RentalObjectDTO
import pl.monochrome.manager.service.RentalObjectService

@RestController
@RequestMapping("/rentalobjects")

class RentalObjectController @Autowired constructor(val service: RentalObjectService) {

    @GetMapping
    fun getRentalObjectsForUser(@RequestParam userId: String) = service.getRentalObjectsForUser(userId)

    @PostMapping
    fun addRentalObject(@RequestBody rentalObjectDto: RentalObjectDTO) = service.addRentalObject(rentalObjectDto)

    @PutMapping
    fun updateRentalObject(@RequestBody rentalObjectDto: RentalObjectDTO) = service.updateRentalObject(rentalObjectDto)

    @GetMapping("/{id}")
    fun getRentalObject(@PathVariable rentalObjectId: Int) = service.getRentalObject(rentalObjectId)

    @DeleteMapping("/{id}")
    fun deleteRentalObject(@PathVariable rentalObjectId: Int) = service.deleteRentalObject(rentalObjectId)

}