package pl.monochrome.manager.repository

import org.springframework.data.jpa.repository.JpaRepository
import pl.monochrome.manager.model.database.Guest
import pl.monochrome.manager.model.database.UserGuestKey
import java.util.*

interface GuestRepository: JpaRepository<Guest, UserGuestKey> {
    fun findAllByUserId(id: String): Set<Guest>
}