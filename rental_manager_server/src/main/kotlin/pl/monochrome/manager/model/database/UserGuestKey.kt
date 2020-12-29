package pl.monochrome.manager.model.database

import java.io.Serializable
import javax.persistence.Column
import javax.persistence.Embeddable

@Embeddable
data class UserGuestKey(

    @Column(name = "user_id")
    val userId: String,

    @Column(name = "person_id")
    val personId: Int

) : Serializable