Register password input
=======================

**Summary**: Provides default UI for selecting a password.

Includes functionality that allows the input of passwords as well as validation
against rules that can be setup server-side, such as minimum and maximum
username length, regex rules, etc.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyIntroActivity">

      <tv.superawesome.pj.ui.registerpassword.views.RegisterPasswordView
        android:id="@+id/register_password"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **RegisterPasswordView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyIntroActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        register_password.setSkin(RegisterPasswordSkin())
        register_password.bindTo(context.application.store)
      }

      override fun onDestroy() {
        register_password.unbindFrom(context.application.store)
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

		interface IRegisterPasswordDelegate {
		    fun onInputUpdated(input: String, isValid: Boolean)
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    register_password.setDelegate(some_object)

Furthermore, the view can have a soft keyboard hook to notify when the "Done"
button has been clicked.

.. code-block:: java

    register_password.setKeyboardHook(object: View.OnClickListener {
      fun onClick(v: View?) {
        // perform action on soft keyboard "Done" click
      }
    })

.. note::
    Notice anything that implements **View.OnClickListener** can play the role of keyboard hook. To ease this, the **RegisterButton** and **LoginButton** views also implement this interface.

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

		interface IRegisterPasswordSkin : ISkin {
		    val layout: Int
		    val passwordInput: Int
		}
