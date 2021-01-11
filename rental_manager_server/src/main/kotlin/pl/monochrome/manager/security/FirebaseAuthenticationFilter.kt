package pl.monochrome.manager.security

import com.google.auth.oauth2.GoogleCredentials
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseAuthException
import org.springframework.core.env.Environment
import java.io.FileInputStream
import javax.servlet.FilterChain
import javax.servlet.http.HttpFilter
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse

class FirebaseAuthenticationFilter(environment: Environment) : HttpFilter() {

    init {
        val serviceAccount = FileInputStream(environment.getRequiredProperty("firebase.service.key.path"))
        val options = FirebaseOptions.builder()
            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
            .setDatabaseUrl("https://rentalmanager-9f506.firebaseio.com")
            .build()
        FirebaseApp.initializeApp(options)
    }

    override fun doFilter(request: HttpServletRequest?, response: HttpServletResponse?, chain: FilterChain?) {
        val authenticationToken = request?.getHeader("Authorization")?.drop(7)
        if (authenticationToken.isNullOrEmpty()) {
            response?.status = HttpServletResponse.SC_UNAUTHORIZED
            return
        } else {
            try {
                val decodedToken = FirebaseAuth.getInstance().verifyIdToken(authenticationToken)
                if (decodedToken.uid == request.getParameter("userId")) {
                    chain?.doFilter(request, response)
                } else {
                    response?.status = HttpServletResponse.SC_UNAUTHORIZED
                    return
                }
            } catch (exception: FirebaseAuthException) {
                response?.status = HttpServletResponse.SC_UNAUTHORIZED
                return
            }
        }
    }
}