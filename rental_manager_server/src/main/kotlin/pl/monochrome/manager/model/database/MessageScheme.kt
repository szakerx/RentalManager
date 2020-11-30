package pl.monochrome.manager.model.database

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "message_schemes")
data class MessageScheme(

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        val id: UUID,

        @Column
        val name: String,

        @Column
        val content: String,

        @ManyToOne
        val user: User
)