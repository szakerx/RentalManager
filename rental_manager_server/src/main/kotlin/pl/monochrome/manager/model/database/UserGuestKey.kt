package pl.monochrome.manager.model.database

import java.io.Serializable
import java.util.*
import javax.persistence.Column
import javax.persistence.Embeddable

@Embeddable
data class UserGuestKey(

        @Column(name = "user_id")
        val userId: UUID,

        @Column(name = "guest_id")
        val guestId: UUID,
): Serializable