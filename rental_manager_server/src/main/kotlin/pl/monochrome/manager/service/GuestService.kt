package pl.monochrome.manager.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.data.repository.findByIdOrNull
import org.springframework.stereotype.Service
import pl.monochrome.manager.model.database.Guest
import pl.monochrome.manager.model.database.UserGuestKey
import pl.monochrome.manager.repository.GuestRepository
import java.util.*

@Service
class GuestService @Autowired constructor(private val repository: GuestRepository) {
    fun getAllGuests(userId: String): List<Guest> = repository.findByUser_Id(userId)

    fun getGuest(userId: String, guestId: Int) = repository.findByIdOrNull(UserGuestKey(userId, guestId))
}