User settings
=============

**Summary**: Provides default UI for customising a user's profile.

Includes functionality that that can link to other screens where a user can
update their avatar or cover image, update their bio.

Includes out-of-the-box functionality that can link to privacy policy and
terms&conditions urls.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyIntroActivity">

      <tv.superawesome.pj.ui.settings.views.SettingsView
        android:id="@+id/settings"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **SettingsView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyIntroActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        settings.setSkin(SettingsSkin())
        settings.bindTo(context.application.store)
        settings.fetchUser() // local fetch for the currently logged in user
      }

      override fun onDestroy() {
        settings.unbindFrom(context.application.store)
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

		interface ISettingsViewDelegate {
		    fun onClickEmailButton()
		    fun onClickUpdateBio(currentBio: String?)
		    fun onClickGuideTextView()
		    fun onClickFaqTextView()
		    fun onClickSafetyTextView()
		    fun onClickTermsOfServiceTextView()
		    fun onClickPrivacyPolicyTextView()
		    fun onClickLogoutButton()
		    fun onClickEditProfileImage()
		    fun onClickEditCoverImage()
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    settings.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

		interface ISettingsSkin : ISkin {
		    val layout: Int
		    val userNameTextView: Int
		    val bioLayout: Int
		    val bioTextView: Int
		    val bioCounter: Int
		    val userIconImageView: Int
		    val editProfileImageTextView: Int
		    val userCoverImageView: Int
		    val editCoverImageTextView: Int
		    val privacyPolicy1TextView: Int
		    val addEmailButton: Int
		    val guideTextView: Int
		    val faqTextView: Int
		    val safetyTextView: Int
		    val tosTextView: Int
		    val privacyPolicyTextView2: Int
		    val userIdTextView: Int
		    val logOutButton: Int
		}
