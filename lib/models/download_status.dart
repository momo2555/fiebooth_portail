
class DownloadStatus {
  String status;
  int progress;
  String error;
  
  DownloadStatus(
      {required this.status,
      required this.progress,
      required this.error,});
     
  factory DownloadStatus.fromObject(Map<String, dynamic> status) {
    return DownloadStatus(
      status: status["download_status"],
      progress: status["download_progress"],
      error: status["download_error"],
    );
  }
}