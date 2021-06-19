package com.programmers.kmooc.viewmodels

import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.programmers.kmooc.models.LectureList
import com.programmers.kmooc.repositories.KmoocRepository

class KmoocListViewModel(private val repository: KmoocRepository) : ViewModel() {
    private val _lectureList = MutableLiveData<LectureList>()

    val lectureList = _lectureList

    fun list() {
        repository.list { lectureList ->
            _lectureList.postValue(lectureList)
        }
    }

    fun next(currentLectureList: LectureList) {
        repository.next(currentLectureList) { lectureList ->
            lectureList.lectures = currentLectureList.lectures + lectureList.lectures
            _lectureList.postValue(lectureList)
        }
    }
}

class KmoocListViewModelFactory(private val repository: KmoocRepository) :
    ViewModelProvider.Factory {
    override fun <T : ViewModel?> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(KmoocListViewModel::class.java)) {
            return KmoocListViewModel(repository) as T
        }
        throw IllegalAccessException("Unkown Viewmodel Class")
    }
}