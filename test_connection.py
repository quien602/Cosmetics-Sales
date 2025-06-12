@app.route('/test_connection')
def test_connection():
    try:
        # Thực hiện truy vấn đơn giản để kiểm tra kết nối
        db.session.execute('SELECT 1')
        return jsonify({'status': 'success', 'message': 'Kết nối thành công!'})
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})