Set password recovery email
===========================

**Summary**: Provides default UI for helping a user set a password
recovery email.

Includes functionality that allows the input of emails as
well as validation against rules that can be setup server-side,
such as minimum and maximum username length, regex rules, etc.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyIntroActivity">

      <tv.superawesome.pj.ui.recoveryemail.views.RecoveryEmailView
        android:id="@+id/email_view"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **RecoveryEmailView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyIntroActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        email_view.setSkin(RecoveryEmailSkin())
        email_view.bindTo(context.application.store)
      }

      override fun onDestroy() {
        email_view.unbindFrom(context.application.store)
        super.onDestroy()
      }
    }

And that's it!

.. note::
    Notice we have used Kotlin's **Kapt** extension in order to have direct access to the view via its ID. Good alternatives are Jake Wharton's `ButterKnife <http://jakewharton.github.io/butterknife/>`_ library or calling **findViewById** directly.

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

    interface IRecoveryEmailViewDelegate {
      fun onSetUserEmailSuccess()
    }

To assign the view's delegate to some object that implements it:

.. code-block:: java

    email_view.setDelegate(some_object)

Furthermore, the view can have a soft keyboard hook to notify when the "Done"
button has been clicked.

.. code-block:: java

    email_view.setKeyboardHook(object: View.OnClickListener {
      fun onClick(v: View?) {
        // perform action on soft keyboard "Done" click
      }
    })

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

		interface IRecoveryPasswordSkin : ISkin {
		    val layout: Int
		    val usernameInput: Int
		    val emailInput: Int
		    val sumbitButton: Int
		}
