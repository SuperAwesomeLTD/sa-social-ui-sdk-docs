Displaying Search Results
=========================

**Summary**: Provides default UI for searching.

The **Search** view can act as input for the **Search Results** view but it's
not mandatory.

The **Search Results** view provides default UI for displaying search results.

Includes functionality to display user, channel and tag results in
different tiles.

Includes functionality to follow or unfollow a user, channel or tag.

...INSERT IMAGE HERE...

Basic setup
-----------

In order to add it to an Activity, first we must add it to our Fragment or
Activity XML layout.

.. code-block:: XML

    <?xml version="1.0" encoding="utf-8"?>
    <android.support.design.widget.CoordinatorLayout
      tools:context=".activities.MySearchActivity">

      <tv.superawesome.pj.ui.search.view.SearchView
        android:id="@+id/search_box"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"/>

      <tv.superawesome.pj.ui.search.view.SearchResultsView
        android:id="@+id/search_results"
        android:layout_width="match_parent"
        android:layout_height="match_parent"/>

    </android.support.design.widget.CoordinatorLayout>

.. note::
    Notice the actual instance is called **SearchView** or **SearchResultsView**

Once its taken its place in our layout, we can hook it up in code:

.. code-block:: java

    class MySearchActivity: AppCompatActivity() {

      override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        search_box.setSkin(SearchViewSkin())

        search_results.setSkin(SearchResultsViewSkin())
        search_results.bindTo(context.application.store)
        search_results.search("keyword")
      }

      override fun onDestroy() {
        search_results.unbindFrom(context.application.store)
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

The view provides a Delegate interface that it
uses to talk to the outside world. Any class (activity, fragment, etc) can
implement it.

.. code-block:: java

    interface ISearchViewDelegate {
      fun onSearchInputChanged(input: String)
    }

   interface ISearchResultsViewDelegate {
      fun onClickUser(userId: String)
      fun onClickHashTag(hashTag: String)
    }


To assign the view's delegate to some object that implements it:

.. code-block:: java

    search_box.setDelegate(some_object)
    search_results.setDelegate(some_object)

Skinning
--------

Any skin for this view must conform to the following interface:

.. code-block:: java

    // TBC 
