package pl.monochrome.manager.service.db

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.RentalObject
import pl.monochrome.manager.model.dto.RentalObjectDto
import pl.monochrome.manager.repository.RentalObjectRepository

@Service
class RentalObjectService @Autowired constructor(
    private val rentalObjectRepository: RentalObjectRepository,
    private val userService: UserService
) {

    fun getRentalObjectsForUser(userId: String) = rentalObjectRepository.findAllByUserId(userId)

    fun getRentalObject(id: Int) = rentalObjectRepository.findById(id).get()

    fun addRentalObject(rentalObjectDto: RentalObjectDto) {
        val rentalObject = dtoToObject(rentalObjectDto)
        rentalObjectRepository.save(rentalObject)
    }

    fun updateRentalObject(rentalObjectDto: RentalObjectDto) {
        val rentalObject = dtoToObject(rentalObjectDto)
        rentalObjectRepository.save(rentalObject)
    }

    fun deleteRentalObject(rentalObjectId: Int) {
        rentalObjectRepository.deleteById(rentalObjectId)
    }

    private fun dtoToObject(rentalObjectDto: RentalObjectDto): RentalObject {
        val user = userService.getUserById(rentalObjectDto.userId)
        return RentalObject(
            id = rentalObjectDto.id,
            maxGuest = rentalObjectDto.maxGuests,
            description = rentalObjectDto.description,
            name = rentalObjectDto.name,
            type = rentalObjectDto.type,
            allowedAnimals = rentalObjectDto.allowedAnimals,
            user = user
        )
    }

}