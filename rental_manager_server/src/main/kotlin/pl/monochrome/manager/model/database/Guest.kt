package pl.monochrome.manager.model.database

import javax.persistence.*

@Entity
@Table(name = "guests")
data class Guest(

        @EmbeddedId
        val id: UserGuestKey,

        @ManyToOne
        @MapsId("userId")
        @JoinColumn(name = "user_id")
        val user: User,

        @ManyToOne
        @MapsId("personId")
        @JoinColumn(name = "person_id")
        var person: Person,

        @Column
        val note: String

)