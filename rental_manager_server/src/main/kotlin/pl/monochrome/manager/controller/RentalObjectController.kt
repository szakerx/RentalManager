package pl.monochrome.manager.controller

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController
import pl.monochrome.manager.model.database.RentalObject
import pl.monochrome.manager.service.RentalObjectService
import java.util.*

@RestController
@RequestMapping("/objects")

class RentalObjectController @Autowired constructor(val service: RentalObjectService) {

    @GetMapping
    fun getAllRentalObjects() = service.getAllRentalObjects()

    @GetMapping("/{id}")
    fun getRentalObject(@PathVariable id: UUID): RentalObject = service.getRentalObject(id).get()

}