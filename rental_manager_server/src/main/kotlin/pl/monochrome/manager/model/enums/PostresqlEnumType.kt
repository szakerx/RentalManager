package pl.monochrome.manager.model.enums

import org.hibernate.engine.spi.SharedSessionContractImplementor

import java.sql.PreparedStatement
import java.sql.Types

class PostgresqlEnumType: org.hibernate.type.EnumType<Enum<*>>() {
    override fun nullSafeSet(
        st: PreparedStatement,
        value: Any?,
        index: Int,
        session: SharedSessionContractImplementor
    ) {
        st.setObject(
            index,
            if (value != null) (value as Enum<*>).name else null,
            Types.OTHER
        )
    }
}
