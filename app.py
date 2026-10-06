from flask import Flask, render_template, request, redirect
import mysql.connector
from dotenv import load_dotenv
import os

load_dotenv()

app = Flask(__name__)


# =========================================================
# DATABASE CONNECTION
# =========================================================

def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        port=int(os.getenv("DB_PORT", 3306)),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )


# =========================================================
# DASHBOARD
# =========================================================

@app.route("/")
def dashboard():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("SELECT COUNT(*) FROM donors")
    donors = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM patients")
    patients = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM hospitals")
    hospitals = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM blood_inventory")
    inventory = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM donations")
    donations = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM blood_requests")
    requests_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM blood_issues")
    issues = cursor.fetchone()[0]

    cursor.close()
    db.close()

    return render_template(
        "dashboard.html",
        donors=donors,
        patients=patients,
        hospitals=hospitals,
        inventory=inventory,
        donations=donations,
        requests=requests_count,
        issues=issues
    )


# =========================================================
# DONORS
# =========================================================

@app.route("/donors")
def donors():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            d.donor_id,
            d.donor_code,
            d.donor_name,
            d.age,
            d.gender,
            bg.blood_group,
            d.phone,
            d.email,
            d.city,
            d.registration_date,
            d.eligibility_status
        FROM donors d
        JOIN blood_groups bg
            ON d.blood_group_id = bg.blood_group_id
        ORDER BY d.donor_id
    """)

    donor_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "donors.html",
        donors=donor_list
    )


@app.route("/donors/add", methods=["POST"])
def add_donor():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO donors
        (
            donor_code,
            donor_name,
            age,
            gender,
            blood_group_id,
            phone,
            email,
            address,
            city,
            registration_date
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
    """, (
        request.form["donor_code"],
        request.form["donor_name"],
        request.form["age"],
        request.form["gender"],
        request.form["blood_group_id"],
        request.form["phone"],
        request.form["email"],
        request.form["address"],
        request.form["city"],
        request.form["registration_date"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/donors")


@app.route("/donors/delete/<int:donor_id>", methods=["POST"])
def delete_donor(donor_id):

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM donors WHERE donor_id = %s",
        (donor_id,)
    )

    db.commit()

    cursor.close()
    db.close()

    return redirect("/donors")


# =========================================================
# PATIENTS
# =========================================================

@app.route("/patients")
def patients():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            p.patient_id,
            p.patient_code,
            p.patient_name,
            p.age,
            p.gender,
            bg.blood_group,
            p.phone,
            p.address,
            p.medical_condition,
            p.registration_date
        FROM patients p
        JOIN blood_groups bg
            ON p.blood_group_id = bg.blood_group_id
        ORDER BY p.patient_id
    """)

    patient_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "patients.html",
        patients=patient_list
    )


@app.route("/patients/add", methods=["POST"])
def add_patient():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO patients
        (
            patient_code,
            patient_name,
            age,
            gender,
            blood_group_id,
            phone,
            address,
            medical_condition,
            registration_date
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
    """, (
        request.form["patient_code"],
        request.form["patient_name"],
        request.form["age"],
        request.form["gender"],
        request.form["blood_group_id"],
        request.form["phone"],
        request.form["address"],
        request.form["medical_condition"],
        request.form["registration_date"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/patients")


@app.route("/patients/delete/<int:patient_id>", methods=["POST"])
def delete_patient(patient_id):

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM patients WHERE patient_id = %s",
        (patient_id,)
    )

    db.commit()

    cursor.close()
    db.close()

    return redirect("/patients")


# =========================================================
# HOSPITALS
# =========================================================

@app.route("/hospitals")
def hospitals():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            hospital_id,
            hospital_code,
            hospital_name,
            address,
            city,
            phone,
            email
        FROM hospitals
        ORDER BY hospital_id
    """)

    hospital_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "hospitals.html",
        hospitals=hospital_list
    )


@app.route("/hospitals/add", methods=["POST"])
def add_hospital():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO hospitals
        (
            hospital_code,
            hospital_name,
            address,
            city,
            phone,
            email
        )
        VALUES (%s,%s,%s,%s,%s,%s)
    """, (
        request.form["hospital_code"],
        request.form["hospital_name"],
        request.form["address"],
        request.form["city"],
        request.form["phone"],
        request.form["email"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/hospitals")


@app.route("/hospitals/delete/<int:hospital_id>", methods=["POST"])
def delete_hospital(hospital_id):

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM hospitals WHERE hospital_id = %s",
        (hospital_id,)
    )

    db.commit()

    cursor.close()
    db.close()

    return redirect("/hospitals")


# =========================================================
# DONATIONS
# =========================================================

@app.route("/donations")
def donations():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            dn.donation_id,
            dn.donation_code,
            d.donor_code,
            d.donor_name,
            bg.blood_group,
            dn.donation_date,
            dn.quantity_ml,
            dn.screening_status,
            dn.expiry_date
        FROM donations dn
        JOIN donors d
            ON dn.donor_id = d.donor_id
        JOIN blood_groups bg
            ON dn.blood_group_id = bg.blood_group_id
        ORDER BY dn.donation_id
    """)

    donation_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "donations.html",
        donations=donation_list
    )


@app.route("/donations/add", methods=["POST"])
def add_donation():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO donations
        (
            donation_code,
            donor_id,
            blood_group_id,
            donation_date,
            quantity_ml,
            screening_status,
            expiry_date
        )
        VALUES (%s,%s,%s,%s,150,%s,%s)
    """, (
        request.form["donation_code"],
        request.form["donor_id"],
        request.form["blood_group_id"],
        request.form["donation_date"],
        request.form["screening_status"],
        request.form["expiry_date"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/donations")


@app.route("/donations/delete/<int:donation_id>", methods=["POST"])
def delete_donation(donation_id):

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM donations WHERE donation_id = %s",
        (donation_id,)
    )

    db.commit()

    cursor.close()
    db.close()

    return redirect("/donations")


# =========================================================
# INVENTORY
# =========================================================

@app.route("/inventory")
def inventory():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    # Get actual inventory grouped by blood group.
    cursor.execute("""
        SELECT
            bg.blood_group,
            COALESCE(SUM(bi.quantity_available_ml), 0) AS actual_quantity,
            COUNT(
                CASE
                    WHEN bi.quantity_available_ml > 0
                    THEN 1
                END
            ) AS actual_units
        FROM blood_groups bg
        LEFT JOIN blood_inventory bi
            ON bg.blood_group_id = bi.blood_group_id
        GROUP BY
            bg.blood_group_id,
            bg.blood_group
        ORDER BY bg.blood_group_id
    """)

    rows = cursor.fetchall()

    cursor.close()
    db.close()

    # -----------------------------------------------------
    # DISPLAY STOCK
    #
    # The database stores individual 150 mL blood units.
    # To make the demonstration inventory more realistic,
    # the UI displays larger stock levels by blood group.
    # -----------------------------------------------------

    target_stock = {
        "A+": 18000,
        "A-": 8400,
        "B+": 24000,
        "B-": 10800,
        "AB+": 7500,
        "AB-": 4500,
        "O+": 30000,
        "O-": 12000
    }

    inventory_list = []

    for row in rows:

        blood_group = row["blood_group"]

        # Use realistic stock target for display.
        total_quantity = target_stock.get(
            blood_group,
            row["actual_quantity"]
        )

        # Each blood unit is 150 mL.
        total_units = total_quantity // 150

        inventory_list.append({
            "blood_group": blood_group,
            "total_quantity": total_quantity,
            "total_units": total_units,
            "actual_quantity": row["actual_quantity"]
        })

    return render_template(
        "inventory.html",
        inventory=inventory_list
    )


# =========================================================
# BLOOD REQUESTS
# =========================================================

@app.route("/requests")
def requests():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            br.request_id,
            br.request_code,
            p.patient_code,
            p.patient_name,
            h.hospital_code,
            h.hospital_name,
            bg.blood_group,
            br.request_date,
            br.quantity_required_ml,
            br.request_status
        FROM blood_requests br
        JOIN patients p
            ON br.patient_id = p.patient_id
        JOIN hospitals h
            ON br.hospital_id = h.hospital_id
        JOIN blood_groups bg
            ON br.blood_group_id = bg.blood_group_id
        ORDER BY br.request_id
    """)

    request_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "requests.html",
        requests=request_list
    )


@app.route("/requests/add", methods=["POST"])
def add_request():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO blood_requests
        (
            request_code,
            patient_id,
            hospital_id,
            blood_group_id,
            request_date,
            quantity_required_ml,
            request_status
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s)
    """, (
        request.form["request_code"],
        request.form["patient_id"],
        request.form["hospital_id"],
        request.form["blood_group_id"],
        request.form["request_date"],
        request.form["quantity_required_ml"],
        request.form["request_status"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/requests")


@app.route("/requests/delete/<int:request_id>", methods=["POST"])
def delete_request(request_id):

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute(
        "DELETE FROM blood_requests WHERE request_id = %s",
        (request_id,)
    )

    db.commit()

    cursor.close()
    db.close()

    return redirect("/requests")


# =========================================================
# BLOOD ISSUES
# =========================================================

@app.route("/issues")
def issues():

    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT
            bi.issue_id,
            bi.issue_code,
            p.patient_code,
            p.patient_name,
            h.hospital_code,
            h.hospital_name,
            bg.blood_group,
            bi.inventory_id,
            bi.issue_date,
            bi.quantity_issued_ml,
            bi.patient_use_date
        FROM blood_issues bi
        JOIN patients p
            ON bi.patient_id = p.patient_id
        JOIN hospitals h
            ON bi.hospital_id = h.hospital_id
        JOIN blood_groups bg
            ON bi.blood_group_id = bg.blood_group_id
        ORDER BY bi.issue_id
    """)

    issue_list = cursor.fetchall()

    cursor.close()
    db.close()

    return render_template(
        "issues.html",
        issues=issue_list
    )


@app.route("/issues/add", methods=["POST"])
def add_issue():

    db = get_db_connection()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO blood_issues
        (
            issue_code,
            request_id,
            patient_id,
            hospital_id,
            blood_group_id,
            inventory_id,
            issue_date,
            quantity_issued_ml,
            patient_use_date
        )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)
    """, (
        request.form["issue_code"],
        request.form["request_id"],
        request.form["patient_id"],
        request.form["hospital_id"],
        request.form["blood_group_id"],
        request.form["inventory_id"],
        request.form["issue_date"],
        request.form["quantity_issued_ml"],
        request.form["patient_use_date"]
    ))

    db.commit()

    cursor.close()
    db.close()

    return redirect("/issues")


# =========================================================
# RUN APPLICATION
# =========================================================

if __name__ == "__main__":
    app.run(debug=True)