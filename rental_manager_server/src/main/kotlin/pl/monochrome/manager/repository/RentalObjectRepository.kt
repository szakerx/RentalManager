package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.RentalObject

interface RentalObjectRepository: JpaRepository<RentalObject, Int> {

    fun findAllByUserId(userId: String): Set<RentalObject>

}