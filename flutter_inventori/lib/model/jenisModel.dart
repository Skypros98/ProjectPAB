class jenisModel {
  String? id_jenis;
  String? nama_jenis;
  jenisModel(this.id_jenis, this.nama_jenis);
  jenisModel.fromJson(Map<String, dynamic> json) {
    id_jenis = json['id_jenis'];
    nama_jenis = json['nama_jenis'];
  }
}