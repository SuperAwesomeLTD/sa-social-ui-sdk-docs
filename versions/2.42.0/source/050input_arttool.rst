Displaying the Art Tool
=======================

**Summary**: Provides default UI for the art tool

Includes functionality to that allows a user to create drawings with different
brushes, colours, stickers, photos, etc.

.. image:: img/050.arttool.png
	:width: 50%

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MyArtToolActivity">

      <tv.superawesome.sacreationtool.views.CreationToolView
        android:id="@+id/art_tool"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **CreationToolView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MyArtToolActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        art_tool.setSkin(CreationToolSkin())
        art_tool.setStartingImage("__base64_encoded_bitmap__") // optional
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

		interface ICreationToolViewDelegate {
		    fun onFailToRenderImage()
		    fun onTapBack()
		    fun onTapSubmit(imageData: String)
		    fun onRequestStickerKeyboardDismiss()
		    fun onRequestStickerKeyboardOpen()
		    fun onTapTrashDrawing()
		    fun onSaveCreationToCameraRoll()
		    fun onRequestImagePickerViewPresentation()
		}

To assign the view's delegate to some object that implements it:

.. code-block:: java

    art_tool.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

    // TBC
