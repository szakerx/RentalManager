package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.Guest
import pl.monochrome.manager.model.database.UserGuestKey

interface GuestRepository: JpaRepository<Guest, UserGuestKey> {

    fun findAllByUserId(id: String): Set<Guest>

}