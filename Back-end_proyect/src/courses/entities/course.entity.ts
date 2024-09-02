import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  ManyToOne,
  JoinColumn,
  OneToMany,
} from 'typeorm';
import { User } from '../../auth/entities/auth.entity'; // Asegúrate de que la ruta sea correcta
import { Topic } from 'src/topics/entities/topic.entity';
@Entity('courses')
export class Course {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column('text')
  nombre: string;

  @Column('text')
  descripcion: string;

  @Column('text', { unique: true })
  codigo_acceso: string;

  @Column('int', { default: 30 })
  temporizador: number;

  @ManyToOne(() => User, (user) => user.courses, { onDelete: 'CASCADE' })
  @JoinColumn({ name: 'user_id' })
  user: User;

  @OneToMany(() => Topic, (topic) => topic.course)
  topics: Topic[];
}
