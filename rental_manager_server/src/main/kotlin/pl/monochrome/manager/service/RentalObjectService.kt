package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.RentalObject
import pl.monochrome.manager.repository.RentalObjectRepository
import java.util.*

@Service
class RentalObjectService @Autowired constructor(val repository: RentalObjectRepository) {
    fun getAllRentalObjects(): List<RentalObject> = repository.findAll()

    fun getRentalObject(id: UUID) = repository.findById(id)
}