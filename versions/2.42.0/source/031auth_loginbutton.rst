Adding a login button
=====================

**Summary**: Provides default UI for a button that can perform user login.

Includes functionality for specifying a username and password function, so the
information source can be mostly anything (an **EditText** view, another
function, etc)

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyIntroActivity">

      <tv.superawesome.pj.ui.authbutton.views.LoginButton
        android:id="@+id/login_button"
        android:layout_width="match_parent"
        android:layout_height="48dp"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **LoginButton**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyIntroActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        login_button.setUsernameSource { "some-username" }
        login_button.setPasswordSource { "some-password" }
      }
    }

And that's it!

.. note::
    Notice we have used Kotlin's **Kapt** extension in order to have direct access to the view via its ID. Good alternatives are Jake Wharton's `ButterKnife <http://jakewharton.github.io/butterknife/>`_ library or calling **findViewById** directly.

.. note::
    Notice the button can be enabled or disabled based on the validity of a certain username | password pair by calling **login_button.isEnabled = false | true**

Delegate
--------

Most of the functionality that the view performs is executed internally and is
not exposed to the outside.
However there are cases where it's not wise to keep certain actions internal
so as to allow for more flexibility.

To this extent, the view provides a Delegate interface that it
uses to talk to the outside world. Any class (activity, fragment, etc) can
implement it.

.. code-block:: java

    interface SessionDispatcher.Delegate {
      fun onSessionStarted(isSessionStarted: Boolean)
    }

To assign the view's delegate to some object that implements it:

.. code-block:: java

    login_button.setDelegate(some_object)
