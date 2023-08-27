package com.example.test123

import android.content.Intent
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.ViewAssertion
import androidx.test.espresso.action.ViewActions.*
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class MainActivityTest {
    private lateinit var scenario: ActivityScenario<MainActivity>

    @Before
    fun setUp() {
        val intent = Intent(
            ApplicationProvider.getApplicationContext(),
            MainActivity::class.java
        )
        scenario = ActivityScenario.launch<MainActivity>(intent)
            .moveToState(Lifecycle.State.RESUMED)
    }

    @After
    fun tearDown() {
    }

    @Test
    fun testShowButtonSend() {
        onView(withText(R.string.send)).check(matches(isDisplayed()))
    }
}