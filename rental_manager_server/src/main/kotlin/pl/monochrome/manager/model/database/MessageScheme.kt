package pl.monochrome.manager.model.database

import javax.persistence.*

@Entity
@Table(name = "message_schemes")
data class MessageScheme(

        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        val id: Int,

        @Column
        val name: String,

        @Column
        val content: String,

        @ManyToOne
        val user: User?
)