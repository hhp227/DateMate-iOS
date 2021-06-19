package com.programmers.kmooc.activities.detail

import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.ViewModelProvider
import com.programmers.kmooc.KmoocApplication
import com.programmers.kmooc.R
import com.programmers.kmooc.databinding.ActivityKmookDetailBinding
import com.programmers.kmooc.models.Lecture
import com.programmers.kmooc.network.ImageLoader
import com.programmers.kmooc.utils.DateUtil
import com.programmers.kmooc.utils.toVisibility
import com.programmers.kmooc.viewmodels.KmoocDetailViewModel
import com.programmers.kmooc.viewmodels.KmoocDetailViewModelFactory
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class KmoocDetailActivity : AppCompatActivity() {

    companion object {
        const val INTENT_PARAM_COURSE_ID = "param_course_id"
    }

    private lateinit var binding: ActivityKmookDetailBinding
    private lateinit var viewModel: KmoocDetailViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val kmoocRepository = (application as KmoocApplication).kmoocRepository
        viewModel = ViewModelProvider(this, KmoocDetailViewModelFactory(kmoocRepository)).get(
            KmoocDetailViewModel::class.java
        )

        binding = ActivityKmookDetailBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setSupportActionBar(binding.toolbar)
        binding.toolbar.setNavigationOnClickListener { finish() }
        viewModel.detail(intent.getStringExtra(INTENT_PARAM_COURSE_ID)!!)
        subscribeUi()
    }

    private fun subscribeUi() {
        viewModel.lecture.observe(this) { lecture ->
            with(binding) {
                progressBar.visibility = (!viewModel.lecture.hasObservers()).toVisibility()
                supportActionBar?.title = lecture.name
                lectureNumber.setDescription(getString(R.string.lecture_number), lecture.number)
                lectureOrg.setDescription(getString(R.string.lecture_org_name), lecture.orgName)
                lectureType.setDescription(getString(R.string.lecture_type), lecture.classfyName)
                lectureDue.setDescription(getString(R.string.lecture_due), "${DateUtil.formatDate(lecture.start)} ~ ${DateUtil.formatDate(lecture.end)}")
                lecture.teachers?.let { lectureTeachers.setDescription(getString(R.string.lecture_teachers), it) }
                ImageLoader.loadImage(lecture.courseImageLarge) { bitmap ->
                    GlobalScope.launch(Dispatchers.Main) {
                        lectureImage.setImageBitmap(bitmap)
                    }
                }
                webView.loadUrl(lecture.overview)
            }
        }
    }
}